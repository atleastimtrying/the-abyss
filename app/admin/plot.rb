ActiveAdmin.register Plot do
  index do
    column :title
    column :x
    column :y
    column :published
    default_actions
  end

  filter :published

  controller do
    def permitted_params
      params.permit plot: [:x, :y, :title, :description, :published]
    end
  end
end
