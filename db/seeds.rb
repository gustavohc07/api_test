# frozen_string_literal: true

5.times do
  Article.create(title: Faker::Book.title,
                 body: Faker::Lorem.sentence)
end
