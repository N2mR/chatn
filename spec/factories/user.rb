FactoryBot.define do
    factory :user do
      name { "sample" }
      email { "sample@sample.com" }
      password { "password" }
      password_confirmation { "password" }
      search_id { 'sample' }
    end

    factory :sample1, class: User do 
        name { 'ayumu' }
        email { "ayumu@sample.com" }
        password { "password" }
        password_confirmation { "password" }
        search_id { 'ayumu' }
    end
end