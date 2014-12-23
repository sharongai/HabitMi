class AddIconImageToCategories < ActiveRecord::Migration
  def change
    add_attachment :categories, :icon_image
  end
end
