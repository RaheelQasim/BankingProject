import { Component, OnInit } from '@angular/core';
import {Register} from './register';
import {Router} from '@angular/router';
import {FormGroup,FormControl,Validators} from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  register:Register;
  myForm:FormGroup;
  showdetails
  constructor(private routes:Router) {
    this.register=new Register();
    this.myForm=new FormGroup({
      agree:new FormControl(null,Validators.required),
      titles:new FormControl(null,Validators.required),
      fname:new FormControl(null,Validators.required),
      mname:new FormControl(null,Validators.nullValidator),
      lname:new FormControl(null,Validators.required),
      faname:new FormControl(null,Validators.required),
      mob:new FormControl(null,[Validators.required,Validators.min(10)]),
      mail:new FormControl(null,Validators.nullValidator),
      adh:new FormControl(null,[Validators.required,Validators.min(12)]),
      dofb:new FormControl(null,Validators.required),
      addr1:new FormControl(null,Validators.required),
      addr2:new FormControl(null,Validators.required),
      lm:new FormControl(null,Validators.nullValidator),
      st:new FormControl(null,Validators.required),
      ci:new FormControl(null,Validators.required),
      pin:new FormControl(null,[Validators.required]),
      addr1p:new FormControl(null,Validators.nullValidator),
      addr2p:new FormControl(null,Validators.nullValidator),
      lmp:new FormControl(null,Validators.nullValidator),
      stp:new FormControl(null,Validators.nullValidator),
      cip:new FormControl(null,Validators.nullValidator),
      pinp:new FormControl(null,Validators.nullValidator),
      occ:new FormControl(null,Validators.required),
      source:new FormControl(null,Validators.required),
      gross:new FormControl(null,Validators.required)
    });
    this.showdetails=false;
   }
   public get titles(){
    return this.myForm.get('titles');
  }
   public get fname(){
     return this.myForm.get('fname');
   }
   public get mname(){
    return this.myForm.get('mname');
  }
   public get lname(){
    return this.myForm.get('lname');
  }
  public get faname(){
    return this.myForm.get('faname');
  }
  public get mob(){
    return this.myForm.get('mob');
  }
  public get mail(){
    return this.myForm.get('mail');
  }
  public get adh(){
    return this.myForm.get('adh');
  }
  public get dofb(){
    return this.myForm.get('dofb');
  }
  public get addr1(){
    return this.myForm.get('addr1');
  }
  public get addr2(){
    return this.myForm.get('addr2');
  }
  public get lm(){
    return this.myForm.get('lm');
  }
  public get st(){
    return this.myForm.get('st');
  }
  public get ci(){
    return this.myForm.get('ci');
  }
  public get pin(){
    return this.myForm.get('pin');
  }

  public get addr1p(){
    return this.myForm.get('addr1p');
  }
  public get addr2p(){
    return this.myForm.get('addr2p');
  }
  public get lmp(){
    return this.myForm.get('lmp');
  }
  public get stp(){
    return this.myForm.get('stp');
  }
  public get cip(){
    return this.myForm.get('cip');
  }
  public get pinp(){
    return this.myForm.get('pinp');
  }

  public get occ(){
    return this.myForm.get('occ');
  }
  public get source(){
    return this.myForm.get('source');
  }
  public get gross(){
    return this.myForm.get('gross');
  }
  public get agree(){
    return this.myForm.get('agree');
  }

  registerUser(){
    console.log(this.myForm);
    if(this.myForm.valid && this.register.tnc)
    {
      this.showdetails=true;
      this.register.title=this.titles.value;
      this.register.firstname=this.fname.value;
      this.register.middlename=this.mname.value;
      this.register.lastname=this.lname.value;
      this.register.fathername=this.faname.value;
      this.register.mobile=this.mob.value;
      this.register.email=this.mail.value;
      this.register.aadhar=this.adh.value;
      this.register.dob=this.dofb.value;
      this.register.address1=this.addr1.value;
      this.register.address2=this.addr2.value;
      this.register.landmark=this.lm.value;
      this.register.state=this.st.value;
      this.register.city=this.ci.value;
      this.register.pincode=this.pin.value;

      this.register.address1p=this.addr1p.value;
      this.register.address2p=this.addr2p.value;
      this.register.landmarkp=this.lmp.value;
      this.register.statep=this.stp.value;
      this.register.cityp=this.cip.value;
      this.register.pincodep=this.pinp.value;

      this.register.occtype=this.occ.value;
      this.register.sourceincome=this.source.value;
      this.register.grossincome=this.gross.value;
      this.register.tnc=this.agree.value;
      this.routes.navigate(["/register/registered"]);
    }
    console.log(this.showdetails);
    
  }
  optDebit(){
    this.register.optdebitcard=true;
  }
  agreed(){
    this.register.tnc=true;
  }

  ngOnInit(): void {
  }

}
