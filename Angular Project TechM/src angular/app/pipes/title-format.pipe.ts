import { Pipe, PipeTransform } from '@angular/core';

@Pipe({ name: 'titleFormat' })
export class TitleFormatPipe implements PipeTransform {
  transform(value: string): string {
    return value.toUpperCase();
  }
}
