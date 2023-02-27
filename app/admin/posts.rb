# frozen_string_literal: true

ActiveAdmin.register Post do
  index do
    id_column
    column :title
    column :description
  end
end
