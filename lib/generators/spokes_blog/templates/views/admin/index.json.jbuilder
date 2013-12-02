json.aaData do
  json.array!(@posts) do |post|
    json.array! [link_to(post.title, edit_admin_post_path(post)),
      post.author.full_name,
      post.created_by.full_name,
      post.template,
      post.tag_list,
      post.updated_at.strftime("%-m/%d/%y on %-I:%M %p")]
  end
end

