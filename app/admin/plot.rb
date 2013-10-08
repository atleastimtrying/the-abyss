ActiveAdmin.register Plot do
  controller do
    def permitted_params
      params.permit plot: [:x, :y, :title, :description]
    end
  end
end
