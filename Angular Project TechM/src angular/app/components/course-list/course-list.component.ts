import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CourseService } from '../../services/course.service';

@Component({
  selector: 'app-course-list',
  templateUrl: './course-list.component.html',
  styleUrls: ['./course-list.component.css']
})
export class CourseListComponent implements OnInit {
  courses: any[] = [];

  constructor(private courseService: CourseService, private router: Router) {}

  ngOnInit(): void {
    this.getCourses();
  }

  getCourses() {
    this.courseService.getCourses().subscribe((data: any[]) => {
      this.courses = data;
    });
  }

  viewCourse(courseId: number) {
    this.router.navigate(['/course', courseId]);
  }

  editCourse(courseId: number, event: Event) {
    event.stopPropagation();
    this.router.navigate(['/update', courseId]);
  }
}
