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