import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
@Component({
  selector: 'app-forgetpass',
  templateUrl: './forgetpass.component.html',
  styleUrls: ['./forgetpass.component.css']
})
export class ForgetpassComponent implements OnInit {

  constructor() { }
  UserID = new FormControl('');
  otp = new FormControl('');
  proceed(){
    console.log(this.otp.value);
  }
  back(){
    
  }

  ngOnInit(): void {
  }

}
