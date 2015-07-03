class AddDefaultRoleToUser < ActiveRecord::Migration
  	#UP SE USA EN UNA MIGRACION. USERS DE TABLA, NO USER DE MODELO
	def up
		change_column :users, :role, :integer, default: 0, null: false
	end
	#CUANDO SE HACE UN ROOLBACK
	def down
		change_column :users, :role, :integer, default: nil
	end

end
