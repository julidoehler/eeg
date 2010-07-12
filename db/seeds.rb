Gallery.create(:title => 'News Gallery')
Gallery.create(:title => 'Sidepics Gallery')
Gallery.create(:title => 'Projects Gallery')
Gallery.create(:title => 'Members Gallery')

User.create(:email => 'ben@eexistence.de', :password => 'ben', :email_confirmed => true)
User.create(:email => 'adrian@eexistence.de', :password => 'adrian', :email_confirmed => true)
