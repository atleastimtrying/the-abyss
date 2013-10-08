ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "The Abyss" do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Pending Plots" do
          ul do
            Plot.pending.map do |plot|
              li link_to(plot.title, admin_plot_path(plot))
            end
          end
        end
      end

      column do
        panel "The Abyss" do
          para "Welcome to the abyss, you're an admin!"
        end
      end
    end
  end # content
end
