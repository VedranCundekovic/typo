
Given /^the following users exist:$/ do |users_table|
  users_table.hashes.each do |user|
    User.create!({:login => user[:login],
                  :password => user[:password],
                  :email => user[:login].to_s + "@whatever.com",
                  :profile_id => (user[:admin]) ? 1 : 2,
                  :name => user[:name],
                  :state => 'active'})
  end
end


Given /^the following articles exist:$/ do |articles_table|
  articles_table.hashes.each do |article|
    user = User.find_by_login(article[:author])
    # TODO: VEDRAN Should one check if user is found and act accordingly?
    Article.create!({:title => article[:title],
                     :body => article[:body],
                     :published_at => '2005-01-01 02:00:00',
                     :user_id => user.id,
                     :published => true})
  end
end


Given /^I am logged in as (non\-)?admin "(.*?)"$/ do |non_admin, user_login|
  visit '/accounts/login'
  fill_in 'user_login', :with => user_login
  fill_in 'user_password', :with => (non_admin) ? '123456' : '654321' # TODO: VEDRAN Stupid stupid stupid...
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end


Then /^I should not see "(.*?)" button$/ do |button_name|
  if page.respond_to? :should_not
    page.should_not have_selector("input[type=submit][value=button_name]")
  else
    assert page.has_content?(button_name)
  end
end


When /^I merge "(.*?)" and "(.*?)" articles$/ do |title1, title2|
  article1 = Article.find_by_title(title1)
  article2 = Article.find_by_title(title2)

  visit "/admin/content/edit/#{article1[:id]}"
  #step("I am on the edit page for \"#{title1}\" article")

  # TODO: VEDRAN Not done yet!
  fill_in("Article ID", :with => article2.id)
  click_button("Merge With This Article")

end


