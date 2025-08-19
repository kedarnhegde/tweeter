# 🐦 Tweeter App

A Twitter-like application built with **Ruby on Rails** (dev environment only).  
This project follows concepts from [Rails Tutorial (Japanese)](https://railstutorial.jp/).

---

## ⚙️ Requirements
- **Ruby** 2.7.4  
- **Rails** 5.1.6  

---

## ✨ Features
- 👤 **User Management**  
  - Create a new user  
  - Login/logout  
  - Update personal details (name, email, password)  
  - Delete users (only admins can delete non-admin users)  

- ✅ **Validations**  
  - **Name:** must exist, max 50 chars  
  - **Email:** must exist, max 255 chars, valid format  
  - **Password:** must exist, min 8 chars, confirmation required  
  - Password can be blank when editing, but **not** when creating a user  

- 🔐 **Authentication**  
  - Session management with "Remember Me" (stay logged in even after browser close)  

- 📧 **Account Activation**  
  - New accounts require activation via email  
  - *Dev-only note*: no real emails sent; activate manually in DB or via seeds  

- 🔑 **Forgot Password**  
  - Password reset flow included  
  - *Dev-only note*: no real emails sent; update manually in DB or via seeds  

- 📝 **Microposts (Tweets)**  
  - Users can post short updates  

- 🔄 **Following System**  
  - Follow/unfollow other users  
  - See microposts of followed users in your feed  

- 🌍 **Internationalization (i18n)**  
  - Available in **English** and **Japanese**  
  - Language is auto-detected from user's locale in user table (default: English)  

---

## 🚀 Getting Started

Clone the repo and install dependencies:

```bash
git clone https://github.com/kedarnhegde/tweeter.git
cd tweeter
bundle install
```

## Set up the database:

```bash
rails db:migrate:reset
rails db:seed   # loads dummy data
```

## Start the server:

```bash
rails s
```

- App will be running at http://localhost:3000
- You can either create a new user or log in with a seeded account.
  - For new users, email verification must be bypassed (since no production emails are sent).

## 🧪 Running Tests

```bash
rails t
```

## 🛠️ Developer Tools

- Rails console:

```bash
rails c
```

- DB seeding available in `db/seeds.rb`

## 📌 Notes

- This is a dev-env only app — no production deployment.
- Emails (activation, password reset) are not actually sent; use seeds or DB updates.
