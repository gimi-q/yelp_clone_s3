def sign_up
  click_link("Sign up")
   fill_in("Email", with: "test@test.com")
   fill_in("Password", with: "testtest")
   fill_in("Password confirmation", with: "testtest")
   click_button("Sign up")
end