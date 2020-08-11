import { Component, OnInit } from '@angular/core';
import {login} from '../loginpage/login';
import {FormsModule,FormGroup,Validators, FormControl} from '@angular/forms'

import {Router} from '@angular/router'

@Component({
  selector: 'app-loginpage',
  templateUrl: './loginpage.component.html',
  styleUrls: ['./loginpage.component.css']
})
export class LoginpageComponent implements OnInit {

  loginex:login;
  welcome:boolean;
  myForm:FormGroup;
  wrongcredentials:boolean;
  constructor(private route:Router) {
    this.loginex=new login("demo",1234);
    this.myForm=new FormGroup({
      username:new FormControl(null,Validators.required),
      password:new FormControl(null,Validators.required)
    });
    this.welcome=false;
    this.wrongcredentials=false;
   }

   public get username(){
     return this.myForm.get("username");
   }
   public get password(){
     return this.myForm.get("password");
   }

  ngOnInit(): void {
  }

  checkpassword(){
    this.welcome=false;
    if(this.password.value==this.loginex.password&&this.username.value==this.loginex.username){
      this.welcome=true;
    }
    else
      this.wrongcredentials=true;
    
  }
}
