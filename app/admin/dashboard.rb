ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel "Studies" do
          ul do
            Study.all.map do |study|
              if study.identifier.present? and study.name.present?
                li link_to(study.identifier.to_s + ': ' + study.name.to_s, admin_study_path(study))
              end
            end
          end
        end

        panel "Participants" do
          ul do
            Participant.all.map do |participant|
              if participant.identifier.present? and participant.id.present?
                li link_to(participant.identifier.to_s + ' (' + participant.id.to_s + ')', admin_participant_path(participant))
              end
            end
          end
        end
      end


    end


  end # content
end
