ActiveAdmin.register Plot do
  index do
    selectable_column
    column :title
    column :x
    column :y
    column :published
    default_actions
  end

  filter :published

  batch_action :publish do |selection|
    Plot.find(selection).each do |plot|
      plot.update_attributes published: true
    end
    redirect_to collection_path, notice: "published"
  end

  batch_action :unpublish do |selection|
    Plot.find(selection).each do |plot|
      plot.update_attributes published: false
    end
    redirect_to collection_path, alert: "unpublished"
  end

  controller do
    def permitted_params
      params.permit plot: [:x, :y, :title, :description, :published]
    end
  end
end
