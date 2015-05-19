class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

#antes de guardar cualquier usuario en la bd, ejecuta este metodo.
        #before_save :default_role

        validates :name, presence: true

        has_many :posts, dependent: :destroy 
        has_many :comments, dependent: :destroy 

        #enum para que guarde el role como 0 o 1	
        enum role: [:guest, :moderator]

        ##role por default es 0 (guest), pero lo usaremos como migracion, por que es mejor.
        #def default_role
        #	self.role ||= 0
        #end

       #carrierwave. llama a un metodo que se llama mount uploader, que pasa los 
       #argumentos avatar y avataruploader. Puede ir con parentesis o no
       #mount_uploader (:avatar, avataruploader). avatar es el campo.
       
       mount_uploader  :avatar, AvatarUploader 
end
