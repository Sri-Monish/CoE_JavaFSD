import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CourseListComponent } from './components/course-list/course-list.component';
import { CourseDetailsComponent } from './components/course-details/course-details.component';
import { AddCourseComponent } from './components/add-course/add-course.component';
import { UpdateCourseComponent } from './components/update-course/update-course.component';
import { LoginComponent } from './components/login/login.component';
import { AuthGuard } from './guards/auth.guard';
import { HomeComponent } from './components/home/home.component';
const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: '', component: HomeComponent, canActivate: [AuthGuard] }, // Home Page as Default
  { path: 'courses', component: CourseListComponent, canActivate: [AuthGuard] }, // Courses Page
  { path: 'course/:id', component: CourseDetailsComponent, canActivate: [AuthGuard] }, // Course Details
  { path: 'add', component: AddCourseComponent, canActivate: [AuthGuard] }, // Add Course
  { path: 'update/:id', component: UpdateCourseComponent, canActivate: [AuthGuard] }, // Update Course
  { path: '**', redirectTo: 'login' } // Redirect unknown routes to login
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
