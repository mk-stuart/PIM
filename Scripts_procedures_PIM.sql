
---------------- insert user ----------------------------
CREATE OR REPLACE PROCEDURE ni_sp_insert_user (
   FIRST_NAME_IN        IN      new_itens_owner.ni_user.first_name%type,
   LAST_NAME_IN         IN      new_itens_owner.ni_user.last_name%type,
   CPF_IN               IN      new_itens_owner.ni_user.cpf%type,     
   EMAIL_IN             IN      new_itens_owner.ni_user.email%type,
   PASSWORD_IN          IN      new_itens_owner.ni_user.password%type,
   PHONE_NUMBER_IN      IN      new_itens_owner.ni_user.phone_number%type,
   CELPHONE_NUMBER_IN   IN      new_itens_owner.ni_user.celphone_number%type,
   BIRTH_DATE_IN        IN      new_itens_owner.ni_user.birth_date%type,               
   USER_ID_OUT          OUT     new_itens_owner.ni_user.user_id%type
)
IS
BEGIN
    USER_ID_OUT := ni_seq_user.nextval;
    insert into new_itens_owner.ni_user(user_id, first_name, last_name, cpf, email, password, phone_number, celphone_number, birth_date) 
    values (USER_ID_OUT, FIRST_NAME_IN, LAST_NAME_IN, CPF_IN, EMAIL_IN, PASSWORD_IN, PHONE_NUMBER_IN, CELPHONE_NUMBER_IN, BIRTH_DATE_IN); 
END ni_sp_insert_user;
---------------------------------------------------------
--------------------- insert product --------------------