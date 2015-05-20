class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

#antes de guardar cualquier usuario en la bd, ejecuta este metodo.
        #before_save :default_role

        validates :name, presence: true
        

        has_many :posts, dependent: :destroy 
        has_many :comments, dependent: :destroy
        #para borrar usuario 
        has_many :identities, dependent: :destroy

        #enum para que guarde el role como 0 o 1	
        enum role: [:guest, :moderator]

        ##role por default es 0 (guest), pero lo usaremos como migracion, por que es mejor.
        #def default_role
        #	self.role ||= 0
        #end

def self.find_for_oauth(auth, signed_in_resource = nil)
 
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
 
    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user
 
    # Create the user if needed
    if user.nil?
 
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
 
      # Create the user if it's a new registration
      if user.nil?
        if identity.provider == "twitter"
            user = User.new(
              name: auth.extra.raw_info.name ? auth.extra.raw_info.name : auth.info.nickname,
              #@username: auth.info.nickname || auth.uid,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              password: Devise.friendly_token[0,20]
            )
          else
            user = User.new(
              name: auth.info.name, 
              #username: auth.info.username || auth.uid,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              #toma el avatar remoto,y gsub lo transforma como https, por que http 
              #manda error. Esta solucion esta mala, ya que afecta al modelo, y no hay que tocarlo
              #remote_avatar_url: auth[:info][:image].gsub('http://','https://'),
              password: Devise.friendly_token[0,20]
              #avatar: auth.extra.raw_info.image ? auth.extra.raw_info.image : " "
            )
          end
        user.save!
      end
    end
 
    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
 
  def email_verified?
    self.email
  end

       #carrierwave. llama a un metodo que se llama mount uploader, que pasa los 
       #argumentos avatar y avataruploader. Puede ir con parentesis o no
       #mount_uploader (:avatar, avataruploader). avatar es el campo.
       
       mount_uploader  :avatar, AvatarUploader 
end
