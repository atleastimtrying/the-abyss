ActiveAdmin.register Item do
  index do
    selectable_column
    column :title
    column :x
    column :y
    default_actions
  end

  filter :published

  controller do
    def permitted_params
      params.permit item: [:x, :y, :title, :description]
    end
  end
end
