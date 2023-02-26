ActiveAdmin.register User do
  index do
    id_column
    column :nickname
    column :email
  end
end
