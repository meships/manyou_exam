FactoryBot.define do
  factory :task do
    title {'うんち'}
    content {'うんちの中身'}
    limit {'2022/12/14'}
    status {3}
    priority {1}
  end
  factory :second_task, class: Task do
    title {'タイトル2'}
    content {'タイトル2'}
    limit {'2022/12/14'}
    status {'未着手'}
    priority {'中'}
  end

end