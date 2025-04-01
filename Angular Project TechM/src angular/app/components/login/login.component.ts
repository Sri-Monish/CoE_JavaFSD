import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  username: string = '';
  password: string = '';

  constructor(private router: Router) {}

  login() {
    console.log("Entered Credentials - Username:", this.username, "Password:", this.password);

    if (this.username.trim() === 'admin' && this.password.trim() === 'password') {
      localStorage.setItem('auth', 'true'); // Store login status
      this.router.navigate(['/']); // Redirect to home page
    } else {
      alert('Invalid credentials! Use Username: admin, Password: password');
    }
  }
}
