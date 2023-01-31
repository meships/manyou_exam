# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name: 'adminuser',
    email: 'admin@ymail.com',
    password: 'adminuser',
    password_confirmation: 'adminuser',
    admin: true)

10.times do |n|
    User.create!(
        name: "bodybag#{n + 1}",
        email: "bodybag#{n + 1}@seed.com",
        password: "bodybag1@seed.com",
        password_confirmation: "bodybag1@seed.com",
    )
end

labels = [
    {id: 1, label_name: "ライフル"},
    {id: 2, label_name: "マシンガン"},
    {id: 3, label_name: "ショットガン"},
    {id: 4, label_name: "ハンドガン"},
    {id: 5, label_name: "パルスライフル"},
    {id: 6, label_name: "レーザーライフル"},
    {id: 7, label_name: "グレネードランチャー"},
    {id: 8, label_name: "スナイパーライフル"},
    {id: 9, label_name: "レーザーブレード"},
    {id: 10, label_name: "パイルバンカー"},
]
labels.each do |label|
    Label.find_or_create_by(label)
end

start_day = Date.new(2020,1,1)
last_day = Date.new(2023,12,31)

users = User.all

users = users.map{|user|user.id}

100.times{|n|
    Task.create!(
        title: "タスク名#{n + 1}",
        content: "すぐに消せ#{n + 1}",
        limit: rand(start_day..last_day),
        status: rand(1..3),
        priority: rand(1..3),
        user_id: users.sample
    )
}

tasks = Task.all
tasks = tasks.map{|task|task.id}

100.times{|n|
    Labelling.create(
        label_id: rand(1..10),
        task_id: tasks.sample
    )
}