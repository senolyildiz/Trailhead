import { LightningElement, api } from 'lwc';

export default class ChildCom extends LightningElement {
myTitle;

@api
get title(){
    return this.myTitle

}

set title(value){
    this.myTitle = value.toUpperCase();
    this.setAttribute('title', this.myTitle);

}


}