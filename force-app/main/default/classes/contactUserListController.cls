public with sharing class contactUserListController {
    @AuraEnabled (cacheable=true)
    public static list<UserInformation> fetchUserInfo (string contactId){
        try {
            List<UserInformation>listUserInfo= new List <UserInformation>();
            UserInformation objUserInfo= new UserInformation();
            List<Contact> listCnt=new List <Contact>();
            listCnt=[Select Id, Email FROM Contact WHERE Id=: contactId];
            if(listCnt !=Null && listCnt.size()>0){
                string email= listCnt[0].Email;
                if(email!=Null && email!=''){
                    List<User> listUser=[SELECT Id, Name, Email, Phone, Profile.Name From User Where Email=:email];
                    if(listUser!=Null && listUser.size()>0){
                        for(User objUser:listUser){
                            objUserInfo = new UserInformation();
                            objUserInfo.name = objUser.Name;
                            objUserInfo.email = objUser.Email;
                            objUserInfo.phone = objUser.Phone;
                            objUserInfo.profileName = objUser.Profile.Name;
                            objUserInfo.nameLink = '/' + objUser.Id;
                            listUserInfo.add (objUserInfo);
                        }
                    } else {
                                objUserInfo.errorMessage = 'No related user exists on the current contact.';
                                listUserInfo.add(objUserInfo);
                }
                } else{
                    objUserInfo.errorMessage= 'Email does not exist on the current contact.';
                    listUserInfo.add(objUserInfo);
                }
            }
            return listUserInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    public class UserInformation{
        @AuraEnabled public String name;
        @AuraEnabled public String email;
        @AuraEnabled public String phone;
        @AuraEnabled public String profileName;
        @AuraEnabled public String errorMessage;
        @AuraEnabled public String nameLink;  

    }   
}