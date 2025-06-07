# PROFLOW Admin Panel

A modern, scalable admin panel built with Rails 8.0, featuring dark/light theme switching, role-based access control, and a responsive Bootstrap interface.

## 🚀 Features

- **Rails 8.0** with modern Ruby features
- **Bootstrap 5** responsive design
- **Dark/Light theme** toggle with user preferences
- **Role-based authentication** (User, Admin, Super Admin)
- **CanCanCan authorization** system
- **Responsive admin interface** built with Slim templates
- **Universal confirm modals** replacing browser dialogs
- **Docker ready** for easy deployment
- **MySQL database** with proper indexing

## 🛠 Tech Stack

- **Backend**: Ruby on Rails 8.0
- **Database**: MySQL 8.0
- **Frontend**: Bootstrap 5, Stimulus JS
- **Templates**: Slim
- **Icons**: Bootstrap Icons
- **Authentication**: Devise
- **Authorization**: CanCanCan
- **Rich Text**: Action Text with Trix
- **Assets**: Import Maps

## 🔧 Setup

### Development with Docker

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/proflow.git
cd proflow

# Build and run with Docker Compose
docker-compose up --build

# Setup database (in another terminal)
docker-compose exec web rails db:create db:migrate db:seed
```

### Local Development

```bash
# Install dependencies
bundle install
yarn install

# Setup database
rails db:create db:migrate db:seed

# Start the server
rails server
```

## 👤 Default Users

After running `db:seed`, you can login with:

- **Super Admin**: admin@proflow.app / password123
- **Regular User**: user@proflow.app / password123

## 📱 Features Overview

### User Management
- Create, edit, delete users
- Role assignment (User/Admin/Super Admin)
- Theme preference per user
- Profile management

### Static Pages
- Rich text content editing
- Published/Draft status
- SEO-friendly URLs with slugs
- Public page preview

### Theme System
- Real-time dark/light theme switching
- User preference persistence
- Smooth CSS transitions
- Bootstrap compatible

### Admin Interface
- Responsive dashboard
- Modern UI components
- Universal confirm dialogs
- Breadcrumb navigation

## 🔐 Security

- CSRF protection enabled
- Role-based access control
- Secure user sessions
- SQL injection protection
- XSS prevention

## 🚀 Deployment

The application is Docker-ready and can be deployed to any container platform:

- **Docker Compose** for development
- **Kubernetes** for production
- **Railway**, **Heroku**, or similar platforms

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🐛 Issues

Found a bug? Please create an issue on GitHub with:
- Steps to reproduce
- Expected behavior
- Screenshots (if applicable)
- Environment details

---

Built with ❤️ and lots of ☕ by [Your Name]
