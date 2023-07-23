abstract class States{}
class InitialState extends States{}

class CreateBill extends States{}
class ClearBill extends States{}
class RemoveBillItem extends States{}

class EnterQuantity extends States{}
class CalculateBill extends States{}

class LoadingCreateDataBase extends States{}
class SuccessfullyCreateDataBase extends States{}
class ErrorCreateDataBase extends States{}

class LoadingInsertUserData extends States{}
class SuccessfullyInsertUserData extends States{}
class ErrorInsertUserData extends States{}

class LoadingInsertItemData extends States{}
class SuccessfullyInsertItemData extends States{}
class ErrorInsertItemData extends States{}

class LoadingGetUserData extends States{}
class SuccessfullyGetUserData extends States{}
class ErrorGetUserData extends States{}

class LoadingGetItemData extends States{}
class SuccessfullyGetItemData extends States{}
class ErrorGetItemData extends States{}

class LoadingUpdateItemData extends States{}
class SuccessfullyUpdateItemData extends States{}
class ErrorUpdateItemData extends States{}

class LoadingUpdateUserData extends States{}
class SuccessfullyUpdateUserData extends States{}
class ErrorUpdateUserData extends States{}

class LoadingDeleteItemData extends States{}
class SuccessfullyDeleteItemData extends States{}
class ErrorDeleteItemData extends States{}

class LoadingDeleteUserData extends States{}
class SuccessfullyDeleteUserData extends States{}
class ErrorDeleteUserData extends States{}

class LoadingLogin extends States{}
class SuccessfullyLogin extends States{}
class ErrorLogin extends States{}

class ErrorSearchById extends States{}
class ErrorSearchByName extends States{}
class SuccessfullySearchByName extends States{}
class SuccessfullySearchById extends States{}