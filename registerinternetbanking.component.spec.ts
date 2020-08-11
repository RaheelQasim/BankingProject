import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegisterinternetbankingComponent } from './registerinternetbanking.component';

describe('RegisterinternetbankingComponent', () => {
  let component: RegisterinternetbankingComponent;
  let fixture: ComponentFixture<RegisterinternetbankingComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegisterinternetbankingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegisterinternetbankingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
