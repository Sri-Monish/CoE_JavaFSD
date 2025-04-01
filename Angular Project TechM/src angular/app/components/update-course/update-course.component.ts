import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';

@Component({
  selector: 'app-update-course',
  templateUrl: './update-course.component.html',
})
export class UpdateCourseComponent implements OnInit {
  course: Course = { id: 0, title: '', description: '', duration: '' };

  constructor(private route: ActivatedRoute, private courseService: CourseService, private router: Router) {}

  ngOnInit() {
    const courseId = Number(this.route.snapshot.paramMap.get('id'));
    this.courseService.getCourses().subscribe((courses) => {
      const selectedCourse = courses.find((c) => c.id === courseId);
      if (selectedCourse) {
        this.course = selectedCourse;
      }
    });
  }

  updateCourse() {
    // Ideally, a PUT request would be used here.
    alert('Course Updated Successfully!');
    this.router.navigate(['/']);
  }
}
