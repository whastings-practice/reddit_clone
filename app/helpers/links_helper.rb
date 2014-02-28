module LinksHelper
  def link_form_url(link)
    link.persisted? ? link_url(link) : links_url
  end

  def link_submit_text(link)
    link.persisted? ? "Edit Link" : "Create Link"
  end

  def link_sub_selected?(link, sub)
    link.sub_ids.include?(sub.id) ? "selected": ""
  end

end
