module ApplicationHelper
  def json_link
    content_tag :small, class: "json-link" do
      link_to ".json", { format: :json }
    end
  end
end
