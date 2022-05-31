class PaymentModel {
  bool isPaid;
  bool isCooperate;
  bool isHouse;
  String? locale;
  String? fcmToken;
  String? authKey;
  String? roomName;
  String? roomType;
  String? serviceName;
  String? houseName;
  String? roomId;
  String? serviceId;
  String? houseId;
  String? category;
  String? duration;
  String? minDuration;
  String? amount;
  String? price;
  String? entryDateTime;
  String? exitDateTime;
  String? operatorType;
  String? ussdCode;
  String? referenceNumber;
  String? receiptNumber;
  String? description;
  String? roomsCount;
  String? cooperateNumber;
  PaymentModel(
    this.isHouse,
    this.isCooperate,
    this.isPaid,
    this.roomName,
    this.roomType,
    this.serviceName,
    this.houseName,
    this.roomId,
    this.serviceId,
    this.houseId,
    this.category,
    this.duration,
    this.minDuration,
    this.amount,
    this.entryDateTime,
    this.exitDateTime,
    this.operatorType,
    this.ussdCode,
    this.referenceNumber,
    this.receiptNumber,
    this.price,
    this.description,
    this.roomsCount,
    this.cooperateNumber,
    this.fcmToken,
    this.authKey,
    this.locale,
  );

  bool get getIsHouse => isHouse;

  set setIsHouse(bool isHouse) => this.isHouse = isHouse;

  bool get getIsCooperate => isCooperate;

  set setIsCooperate(bool isCooperate) => this.isCooperate = isCooperate;

  get getRoomName => roomName;

  set setRoomName(roomName) => this.roomName = roomName;

  get getServiceName => serviceName;

  set setServiceName(serviceName) => this.serviceName = serviceName;

  get getHouseName => houseName;

  set setHouseName(houseName) => this.houseName = houseName;

  get getRoomId => roomId;

  set setRoomId(roomId) => this.roomId = roomId;

  get getServiceId => serviceId;

  set setServiceId(serviceId) => this.serviceId = serviceId;

  get getHouseId => houseId;

  set setHouseId(houseId) => this.houseId = houseId;

  get getCategory => category;

  set setCategory(category) => this.category = category;

  get getDuration => duration;

  set setDuration(duration) => this.duration = duration;

  get getAmount => amount;

  set setAmount(amount) => this.amount = amount;

  get getPrice => price;

  set setPrice(price) => this.price = price;

  get getEntryDateTime => entryDateTime;

  set setEntryDateTime(entryDateTime) => this.entryDateTime = entryDateTime;

  get getExitDateTime => exitDateTime;

  set setExitDateTime(exitDateTime) => this.exitDateTime = exitDateTime;

  get getOperatorType => operatorType;

  set setOperatorType(operatorType) => this.operatorType = operatorType;

  get getUssdCode => ussdCode;

  set setUssdCode(ussdCode) => this.ussdCode = ussdCode;

  get getReferenceNumber => referenceNumber;

  set setReferenceNumber(referenceNumber) =>
      this.referenceNumber = referenceNumber;

  get getReceiptNumber => receiptNumber;

  set setReceiptNumber(receiptNumber) => this.receiptNumber = receiptNumber;

  get getDescription => description;

  set setDescription(description) => this.description = description;

  get getRoomType => roomType;

  set setRoomType(roomType) => this.roomType = roomType;

  get getMinDuration => minDuration;

  set setMinDuration(minDuration) => this.minDuration = minDuration;

  get getIsPaid => isPaid;
  set setIsPaid(isPaid) => this.isPaid = isPaid;

  get getCooperateNumber => cooperateNumber;
  set setCooperateNumber(cooperateNumber) =>
      this.cooperateNumber = cooperateNumber;

  get getRoomsCount => roomsCount;
  set setRoomsCount(roomsCount) => this.roomsCount = roomsCount;

  get getFcmToken => fcmToken;
  set setFcmToken(fcmToken) => this.fcmToken = fcmToken;

  get getLocale => locale;
  set setRLocale(locale) => this.locale = locale;

  get getAuthKey => authKey;
  set setAuthKey(authKey) => this.authKey = authKey;
}
