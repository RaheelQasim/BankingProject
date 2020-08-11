import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ForgetuidComponent } from './forgetuid.component';

describe('ForgetuidComponent', () => {
  let component: ForgetuidComponent;
  let fixture: ComponentFixture<ForgetuidComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ForgetuidComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ForgetuidComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
