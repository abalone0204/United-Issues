Fabricator(:post) do
  title { Faker::Lorem.characters(20) }
  content { Faker::Lorem.paragraph(3) }
end


Fabricator(:invalid_post, :from => :post) do
  title { Faker::Lorem.characters(51) }
end
