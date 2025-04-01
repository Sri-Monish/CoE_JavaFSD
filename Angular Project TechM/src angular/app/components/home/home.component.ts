import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  popularCourses = [
    { title: 'Angular Basics', description: 'Learn the basics of Angular.', duration: '5 weeks' },
    { title: 'React JS', description: 'Master React.js efficiently.', duration: '3 months' },
    { title: 'Full Stack Development', description: 'Learn frontend & backend.', duration: '6 months' }
  ];

  constructor(private router: Router) {}

  logout() {
    localStorage.removeItem('auth');
    this.router.navigate(['/login']);
  }
}
