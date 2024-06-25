# coding: utf-8
from sqlalchemy import ARRAY, BigInteger, Boolean, Column, Date, DateTime, Float, ForeignKey, Index, Integer, JSON, Numeric, SmallInteger, String, Table, Text, text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class SequelizeMeta(Base):
    __tablename__ = 'SequelizeMeta'

    name = Column(String(255), primary_key=True)


class Account(Base):
    __tablename__ = 'accounts'

    id = Column(UUID, primary_key=True)
    firstName = Column(String(255))
    lastName = Column(String(255))
    email = Column(String(255), index=True)
    imageUrl = Column(String(255))
    accountType = Column(String(255))
    profileUrl = Column(String(255))
    about = Column(String(255))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    origin = Column(String(255))
    externalId = Column(String(255), index=True)
    discover = Column(String(255))
    phone = Column(String(255))
    utmSource = Column(String(255))
    utmCampaign = Column(String(255))
    utmMedium = Column(String(255))
    referralPartner = Column(String(255))
    acceptedSmsAt = Column(DateTime(True))
    utmContent = Column(String(255))
    utmCampaignId = Column(String(255))


class AdminField(Base):
    __tablename__ = 'admin_fields'

    id = Column(Integer, primary_key=True, server_default=text("nextval('admin_fields_id_seq'::regclass)"))
    name = Column(String(255))
    value = Column(Text)
    relatedEntityId = Column(String(255))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    user = Column(String(255))
    deletedAt = Column(DateTime(True))
    category = Column(String(255))
    relatedEntity = Column(String(255), nullable=False, server_default=text("'Business'::character varying"))


class CredentialSourceType(Base):
    __tablename__ = 'credentialSourceType'

    id = Column(Integer, primary_key=True, server_default=text("nextval('\"credentialSourceType_id_seq\"'::regclass)"))
    name = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))


class DomainEvent(Base):
    __tablename__ = 'domain_events'
    __table_args__ = (
        Index('value_id_index', 'value', 'id'),
    )

    id = Column(BigInteger, primary_key=True, server_default=text("nextval('domain_events_id_seq'::regclass)"))
    value = Column(JSONB(astext_type=Text()), nullable=False)
    version = Column(String(255), nullable=False, server_default=text("'v1.0.0'::character varying"))
    name = Column(String(255))
    relatedEntityId = Column(String(255))
    createdAt = Column(DateTime(True), nullable=False)
    createdAtReferenceDate = Column(DateTime(True), nullable=False)


class LetterBox(Base):
    __tablename__ = 'letter_boxes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('letter_boxes_id_seq'::regclass)"))
    version = Column(String(255), nullable=False)
    type = Column(String(255), nullable=False)
    description = Column(JSONB(astext_type=Text()))
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    status = Column(String(255), nullable=False, server_default=text("'active'::character varying"))


class LocationCategory(Base):
    __tablename__ = 'location_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('location_categories_id_seq'::regclass)"))
    name = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))


class OfferingRequiredMaterial(Base):
    __tablename__ = 'offering_required_materials'

    id = Column(Integer, primary_key=True, server_default=text("nextval('offering_required_materials_id_seq'::regclass)"))
    OfferingId = Column(UUID, nullable=False)
    name = Column(String(255), nullable=False)
    value = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)


class RawInfo(Base):
    __tablename__ = 'raw_infos'
    __table_args__ = (
        Index('raw_infos_relatedEntityrelatedEntityId', 'relatedEntity', 'relatedEntityId'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('raw_infos_id_seq'::regclass)"))
    url = Column(Text)
    type = Column(Text)
    sent = Column(JSONB(astext_type=Text()))
    received = Column(JSONB(astext_type=Text()))
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    relatedEntity = Column(String(255), nullable=False, server_default=text("'Client'::character varying"))
    relatedEntityId = Column(String(255), nullable=False, server_default=text("''::character varying"))


class UserReportCategory(Base):
    __tablename__ = 'user_report_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('user_report_categories_id_seq'::regclass)"))
    parentId = Column(ForeignKey('user_report_categories.id'))
    name = Column(Text)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    parent = relationship('UserReportCategory', remote_side=[id])


class Client(Base):
    __tablename__ = 'clients'

    id = Column(Integer, primary_key=True, server_default=text("nextval('clients_id_seq'::regclass)"))
    accountId = Column(ForeignKey('accounts.id'), nullable=False, index=True)
    accessToken = Column(Text)
    itemId = Column(Text)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    institutionId = Column(String(255))
    origin = Column(String(255), nullable=False)
    externalId = Column(UUID, nullable=False, unique=True, server_default=text("uuid_generate_v4()"))
    context = Column(String(255))
    totalOfFailures = Column(SmallInteger, server_default=text("0"))
    status = Column(String(255), index=True, server_default=text("'active'::character varying"))

    account = relationship('Account')


class CredentialSource(Base):
    __tablename__ = 'credentialSource'

    id = Column(Integer, primary_key=True, server_default=text("nextval('\"credentialSource_id_seq\"'::regclass)"))
    name = Column(String(255), nullable=False)
    credentialSourceTypeId = Column(ForeignKey('credentialSourceType.id'))
    imageUrl = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    credentialSourceType = relationship('CredentialSourceType')


class Customer(Base):
    __tablename__ = 'customers'

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers_id_seq'::regclass)"))
    accountId = Column(ForeignKey('accounts.id', ondelete='RESTRICT'), nullable=False)
    externalId = Column(String(255), nullable=False)
    provider = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    churnedAt = Column(DateTime(True))

    account = relationship('Account')


class Demographic(Base):
    __tablename__ = 'demographics'

    id = Column(UUID, primary_key=True)
    AccountId = Column(ForeignKey('accounts.id', ondelete='SET NULL', onupdate='CASCADE'))
    birthday = Column(DateTime(True))
    isBlack = Column(Boolean)
    isLgbtq = Column(Boolean)
    isFemale = Column(Boolean)
    isMilitary = Column(Boolean)
    isDisabled = Column(Boolean)
    isVeteran = Column(Boolean)
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    genderIdentity = Column(String(255))
    raceAndEthnicity = Column(ARRAY(String(length=255)))
    educationalLevel = Column(String(255))
    dateOfBirth = Column(Date)
    hasDisability = Column(Boolean)
    isLgbtPlus = Column(Boolean)
    isMilitaryOrVeteran = Column(Boolean)

    account = relationship('Account')


class Document(Base):
    __tablename__ = 'documents'

    id = Column(Integer, primary_key=True, server_default=text("nextval('documents_id_seq'::regclass)"))
    accountId = Column(ForeignKey('accounts.id', ondelete='SET NULL', onupdate='CASCADE'))
    type = Column(String(255))
    path = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    createdByEmail = Column(String(255))
    status = Column(String(255))
    origin = Column(String(255))
    mimeType = Column(String(255))

    account = relationship('Account')


class FundingPartner(Base):
    __tablename__ = 'funding_partners'

    id = Column(UUID, primary_key=True)
    AccountId = Column(ForeignKey('accounts.id', ondelete='SET NULL', onupdate='CASCADE'), nullable=False)
    name = Column(String(255))
    about = Column(Text)
    logoUrl = Column(String(255))
    websiteUrl = Column(String(255))
    isCrowdFunding = Column(Boolean, server_default=text("false"))
    isDebtFunding = Column(Boolean, server_default=text("false"))
    isOtherFunding = Column(Boolean, server_default=text("false"))
    hasFundingOpportunities = Column(Boolean, server_default=text("false"))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)

    account = relationship('Account')


class Letter(Base):
    __tablename__ = 'letters'

    id = Column(Integer, primary_key=True, server_default=text("nextval('letters_id_seq'::regclass)"))
    letterBoxId = Column(ForeignKey('letter_boxes.id'), nullable=False)
    version = Column(String(255), nullable=False)
    type = Column(String(255), nullable=False, index=True)
    message = Column(Text)
    attachment = Column(JSONB(astext_type=Text()))
    createdAt = Column(DateTime(True), nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("CURRENT_TIMESTAMP"))

    letter_box = relationship('LetterBox')


class Location(Base):
    __tablename__ = 'locations'

    id = Column(Integer, primary_key=True, server_default=text("nextval('locations_id_seq'::regclass)"))
    categoryId = Column(ForeignKey('location_categories.id', ondelete='SET NULL', onupdate='CASCADE'))
    parentId = Column(ForeignKey('locations.id', ondelete='SET NULL', onupdate='CASCADE'))
    name = Column(String(255), nullable=False)
    abbreviation = Column(String(255))
    latLong = Column(ARRAY(Numeric(precision=10, scale=6)), nullable=False)
    minMaxCodes = Column(ARRAY(String(length=255)), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    location_category = relationship('LocationCategory')
    parent = relationship('Location', remote_side=[id])


class UserReport(Base):
    __tablename__ = 'user_reports'

    id = Column(Integer, primary_key=True, server_default=text("nextval('user_reports_id_seq'::regclass)"))
    categoryId = Column(ForeignKey('user_report_categories.id'))
    rawInfoId = Column(Integer)
    version = Column(Text)
    content = Column(JSONB(astext_type=Text()), nullable=False)
    period = Column(ARRAY(DateTime(timezone=True)), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    relatedEntity = Column(String(255), nullable=False, index=True)
    relatedEntityId = Column(String(255), nullable=False)
    isCacheable = Column(Boolean, index=True, server_default=text("true"))

    user_report_category = relationship('UserReportCategory')


class Business(Base):
    __tablename__ = 'businesses'
    __table_args__ = (
        Index('businesses_created_at_id', 'createdAt', 'id'),
    )

    id = Column(UUID, primary_key=True)
    AccountId = Column(ForeignKey('accounts.id', ondelete='CASCADE', onupdate='CASCADE'), index=True)
    name = Column(String(255))
    city = Column(String(255))
    state = Column(String(255))
    country = Column(String(255))
    websiteUrl = Column(String(255))
    logoUrl = Column(String(255))
    incorporatedAt = Column(DateTime(True))
    productType = Column(String(255))
    category = Column(String(255))
    subcategory = Column(String(255))
    about = Column(String(255))
    instagramHandle = Column(String(255))
    linkedinHandle = Column(String(255))
    twitterHandle = Column(String(255))
    tiktokHandle = Column(String(255))
    isFamiliarWithCdfi = Column(Boolean)
    isFamiliarWithRvb = Column(Boolean)
    hasPreviousOffering = Column(Boolean)
    targetFundingAmount = Column(ARRAY(String(length=255)))
    targetRepaymentYearsMax = Column(Integer)
    isFundsForGrowth = Column(Boolean)
    useOfFunds = Column(Text)
    isFundingReadinessComplete = Column(Boolean)
    lastMonthRevenue = Column(Float(53))
    monthlyRecurringRevenue = Column(Float(53))
    lastMonthExpenses = Column(Float(53))
    creditScore = Column(Integer)
    percentSalesOnline = Column(Float(53))
    guaranteeAmount = Column(Float(53))
    businessGoal = Column(Text)
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    fundingJourney = Column(String(255))
    locationId = Column(ForeignKey('locations.id', ondelete='SET NULL', onupdate='CASCADE'))
    incorporationType = Column(String(255))
    industry = Column(String(255))
    type = Column(ARRAY(String(length=255)))
    lastYearRevenue = Column(Integer)
    lastYearProfit = Column(Integer)
    trailingThreeMonthRevenue = Column(BigInteger)
    trailingThreeMonthProfit = Column(BigInteger)
    outstandingPurchaseOrders = Column(Integer)
    outstandingAccountsReceivable = Column(Integer)
    totalAmountInGovernmentContracts = Column(Integer)
    numberOfLoans = Column(Integer)
    totalAmountInLoans = Column(Integer)
    targetLoanAmount = Column(Integer)
    growthMotivation = Column(ARRAY(String(length=255)))
    loanMotivation = Column(ARRAY(String(length=255)))
    loanTimeframe = Column(ARRAY(Integer()))
    lastBankruptcyDate = Column(DateTime(True))
    shareholderInfo = Column(JSONB(astext_type=Text()))

    account = relationship('Account')
    location = relationship('Location')


t_funding_partner_benefits = Table(
    'funding_partner_benefits', metadata,
    Column('FundingPartnerId', ForeignKey('funding_partners.id'), nullable=False),
    Column('value', String(255), nullable=False),
    Column('createdAt', DateTime(True), nullable=False),
    Column('updatedAt', DateTime(True), nullable=False),
    Column('id', Integer, nullable=False, unique=True, server_default=text("nextval('funding_partner_benefits_id_seq'::regclass)"))
)


class Offering(Base):
    __tablename__ = 'offerings'
    __table_args__ = (
        Index('offerings_created_at_id', 'createdAt', 'id'),
    )

    id = Column(UUID, primary_key=True)
    name = Column(String(255))
    category = Column(String(255))
    subcategory = Column(String(255))
    about = Column(Text)
    FundingPartnerId = Column(ForeignKey('funding_partners.id'))
    minAmount = Column(Float(53))
    maxAmount = Column(Float(53))
    _with = Column('with', String(255))
    _for = Column('for', String(255))
    interestRate = Column(String(255))
    repaymentMonths = Column(Integer)
    targetBusiness = Column(String(255))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    closingFee = Column(Float(53))
    timeToFunding = Column(String(255))
    locationResumeFromRequirements = Column(String(255))
    isVisible = Column(Boolean, server_default=text("true"))

    funding_partner = relationship('FundingPartner')


class Subscription(Base):
    __tablename__ = 'subscriptions'

    id = Column(Integer, primary_key=True, server_default=text("nextval('subscriptions_id_seq'::regclass)"))
    externalId = Column(String(255), nullable=False)
    customerId = Column(ForeignKey('customers.id'), nullable=False)
    items = Column(JSONB(astext_type=Text()), nullable=False)
    price = Column(JSONB(astext_type=Text()), nullable=False)
    status = Column(String(255))
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    customer = relationship('Customer')


class BusinessSavedOffering(Base):
    __tablename__ = 'business_saved_offerings'

    id = Column(UUID, primary_key=True)
    OfferingId = Column(ForeignKey('offerings.id'))
    BusinessId = Column(ForeignKey('businesses.id'))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)

    business = relationship('Business')
    offering = relationship('Offering')


class Credential(Base):
    __tablename__ = 'credential'

    id = Column(UUID, primary_key=True)
    businessId = Column(ForeignKey('businesses.id'))
    credentialSourceId = Column(ForeignKey('credentialSource.id'))
    description = Column(String(255), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    business = relationship('Business')
    credentialSource = relationship('CredentialSource')


class FundingPartnerSavedBusiness(Base):
    __tablename__ = 'funding_partner_saved_businesses'

    id = Column(UUID, primary_key=True)
    FundingPartnerId = Column(ForeignKey('funding_partners.id'))
    BusinessId = Column(ForeignKey('businesses.id'))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)

    business = relationship('Business')
    funding_partner = relationship('FundingPartner')


class IdealMatch(Base):
    __tablename__ = 'ideal_matches'

    businessId = Column(ForeignKey('businesses.id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True)
    offeringId = Column(ForeignKey('offerings.id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False)
    score = Column(Integer, nullable=False)
    details = Column(JSONB(astext_type=Text()))
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    potentialScore = Column(Integer)

    business = relationship('Business')
    offering = relationship('Offering')


class OfferingDetail(Base):
    __tablename__ = 'offering_details'

    id = Column(Integer, primary_key=True, server_default=text("nextval('offering_details_id_seq'::regclass)"))
    name = Column(String(255), nullable=False)
    value = Column(String(255), nullable=False)
    offeringId = Column(ForeignKey('offerings.id'), nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False)

    offering = relationship('Offering')


class Program(Base):
    __tablename__ = 'programs'

    id = Column(UUID, primary_key=True)
    OfferingId = Column(ForeignKey('offerings.id'))
    programType = Column(String(255))
    startDate = Column(String(255))
    endDate = Column(String(255))
    timeline = Column(JSON)
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)

    offering = relationship('Offering')


class Requirement(Base):
    __tablename__ = 'requirements'

    id = Column(UUID, primary_key=True)
    OfferingId = Column(ForeignKey('offerings.id'))
    isStrict = Column(Boolean)
    name = Column(String(255))
    value = Column(ARRAY(String(length=255)), nullable=False, server_default=text("(ARRAY[]::character varying[])::character varying(255)[]"))
    createdAt = Column(DateTime(True), nullable=False)
    updatedAt = Column(DateTime(True), nullable=False)
    rawValue = Column(ARRAY(String(length=255)))
    category = Column(String(255))
    processingLogic = Column(String(255))
    operator = Column(String(255))
    isOptional = Column(Boolean, nullable=False, server_default=text("false"))

    offering = relationship('Offering')


class LocalizableRequirement(Base):
    __tablename__ = 'localizable_requirements'

    requirementId = Column(ForeignKey('requirements.id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False)
    locationId = Column(ForeignKey('locations.id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False)
    createdAt = Column(DateTime(True), nullable=False, server_default=text("now()"))
    updatedAt = Column(DateTime(True), nullable=False, server_default=text("now()"))

    location = relationship('Location')
    requirement = relationship('Requirement')
