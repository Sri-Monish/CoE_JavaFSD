import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';

@Component({
  selector: 'app-course-details',
  templateUrl: './course-details.component.html',
})
export class CourseDetailsComponent implements OnInit {
  course: Course | undefined;

  constructor(private route: ActivatedRoute, private courseService: CourseService) {}

  ngOnInit() {
    const courseId = Number(this.route.snapshot.paramMap.get('id'));
    this.courseService.getCourses().subscribe((courses) => {
      this.course = courses.find((course) => course.id === courseId);
    });
  }
}
