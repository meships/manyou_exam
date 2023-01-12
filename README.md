<h1>User</h1>
<table>
    <tr>
        <th>name</th>
        <td>string</td>
    </tr>
    <tr>
        <th>email</th>
        <td>string</td>
    </tr>
    <tr>
        <th>password_digest</th>
        <td>string</td>
    </tr>
</table>

<br>

<h1>Task</h1>
<table>
    <tr>
        <th>title</th>
        <td>string</td>
    </tr>
    <tr>
        <th>content</th>
        <td>text</td>
    </tr>
    <tr>
        <th>status</th>
        <td>string</td>
    </tr>
    <tr>
        <th>priority</th>
        <td>integer</td>
    </tr>
    <tr>
        <th>limit</th>
        <td>date</td>
    </tr>
</table>    
    <br>
<h1>Label</h1>
<table>
    <tr>
        <th>label_name</th>
        <td>string</td>
    </tr>
</table>
<br>
</table>
<br>
<br>
<br>
<h1>Herokuデプロイ手順</h1>
作成しているアプリのディレクトリに行き
- heroku create

GemfileにGemを追加する（Ruby３系を使用している場合）
- gem 'net-smtp'
- gem 'net-imap'
- gem 'net-pop'
- bundle install

git commitコマンドを使用して、コミット
- git add .
- git commit -m "保存した行動"

Heroku buildpackを追加する
- heroku buildpacks:set heroku/ruby
- heroku buildpacks:add --index 1 heroku/nodejs

heroku stack:set heroku- を行いバージョンを変更する
- heroku stack:set heroku-20

heroku stack で現在使われているstackを確認
- heroku stack
=== ⬢ nameless-crag-77838 Available Stacks
  container
  heroku-18
* heroku-20
  heroku-22

package.json に追加記述
- "engines": {
  "node": "16.x"
  }

Herokuにデプロイ
- git push heroku step2:master

データベースの移行
- heroku run rails db:migrate