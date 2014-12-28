ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password, :password_confirmation, :first_name,
    :last_name, :profile_picture
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def update
      if params[:model][:password].blank?
        params[:model].delete("password")
        params[:model].delete("password_confirmation")
      end
      super
    end
  end

  index do
    selectable_column
    column 'id' do |user|
      link_to user.id, admin_user_path(user)
    end
    column :email
    column :first_name
    column :last_name
    column 'profile_picture' do |user|
      image_tag user.profile_picture.url(:thumb), width: '50px'
    end
    actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :profile_picture, as: :file
    end
    f.actions
  end
end
