module SubsHelper
  def sub_form_url(sub)
    sub.persisted? ? sub_url(sub) : subs_url
  end

  def sub_submit_text(sub)
    sub.persisted? ? "Edit Sub" : "Create Sub"
  end
end
