import { Component } from '@angular/core';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';

@Component({
  selector: 'app-add-course',
  templateUrl: './add-course.component.html',
})
export class AddCourseComponent {
  newCourse: Course = { id: 0, title: '', description: '', duration: '' };

  constructor(private courseService: CourseService) {}

  addCourse() {
    this.courseService.addCourse(this.newCourse).subscribe(() => {
      alert('Course Added!');
      this.newCourse = { id: 0, title: '', description: '', duration: '' };
    });
  }
}
