require 'faker'

User.create!(
    id: 1,
    name: '坂本',
    email: 'busitora@gmail.com',
    password: 'busitora',
    password_confirmation: 'busitora',
    # role: 1
)

User.create!(
    id: 2,
    name: 'UUUM',
    email: Rails.application.credentials.email[:uuum],
    password: Rails.application.credentials.password[:uuum],
    password_confirmation: Rails.application.credentials.password[:uuum],
    )