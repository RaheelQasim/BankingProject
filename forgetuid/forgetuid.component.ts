import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import {  ViewChildren, ElementRef } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-forgetuid',
  templateUrl: './forgetuid.component.html',
  styleUrls: ['./forgetuid.component.css']
})
export class ForgetuidComponent implements OnInit {
  title = 'otp';
  form: FormGroup;
  formInput = ['input1', 'input2', 'input3', 'input4', 'input5', 'input6'];
  @ViewChildren('formRow') rows: any;

  constructor() {
    this.form = this.toFormGroup(this.formInput);
   }
  AccNo = new FormControl('');
  otp = new FormControl('');
  proceed(){}
  back(){}

  toFormGroup(elements) {
    const group: any = {};
    elements.forEach(key => {
      group[key] = new FormControl('', Validators.required);
    });
    return new FormGroup(group);
   }

   keyUpEvent(event, index) {
    let pos = index;
    if (event.keyCode === 8 && event.which === 8) {
      pos = index - 1 ;
    } else {
      pos = index + 1 ;
    }
    if (pos > -1 && pos < this.formInput.length ) {
      this.rows._results[pos].nativeElement.focus();
    }

  }

  onSubmit() {
    console.log(this.form.value);
  }

  ngOnInit(): void {
  }

}
