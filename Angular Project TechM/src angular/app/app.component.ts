import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor(private router: Router) {}

  isLoggedIn(): boolean {
    return localStorage.getItem('auth') === 'true';
  }

  logout() {
    localStorage.removeItem('auth');
    this.router.navigate(['/login']);
  }
}
