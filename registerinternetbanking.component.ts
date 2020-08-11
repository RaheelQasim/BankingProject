import { Component, OnInit } from '@angular/core';
import {FormsModule,Validators,FormGroup, FormControl} from '@angular/forms'
import {login} from '../loginpage/login'

@Component({
  selector: 'app-registerinternetbanking',
  templateUrl: './registerinternetbanking.component.html',
  styleUrls: ['./registerinternetbanking.component.css']
})
export class RegisterinternetbankingComponent implements OnInit {

  myRegisterForm:FormGroup;
  submitstatus:boolean;
  constructor() { 
    this.myRegisterForm=new FormGroup({
      accountnumber:new FormControl(null,Validators.required),
      password:new FormControl(null,Validators.required),
      confirmpassword:new FormControl(null,Validators.required),
      transactionpwd:new FormControl(null,Validators.required),
      confirmtpwd:new FormControl(null,Validators.required),
      OTP:new FormControl(null,Validators.required),
    });
    this.submitstatus=false;
  }
  public get accountnumber(){
    return this.myRegisterForm.get("accountnumber");
  }
  public get password(){
    return this.myRegisterForm.get("password");
  }
  public get confirmpassword(){
    return this.myRegisterForm.get("confirmpassword");
  }
  public get transactionpwd(){
    return this.myRegisterForm.get("transactionpwd");
  }
  public get confirmtpwd(){
    return this.myRegisterForm.get("confirmtpwd");
  }
  public get OTP(){
    return this.myRegisterForm.get("OTP");
  }
  ngOnInit(): void {
  }
  submit(){
    this.submitstatus=true;
  }

}
