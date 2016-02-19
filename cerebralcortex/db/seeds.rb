# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')


# MCerebrumApplication.create!(identifier: "MCA1", applicationtype: "MCA1Type")
# MCerebrumApplication.create!(identifier: "MCA2", applicationtype: "MCA2Type")
# MCerebrumApplication.create!(identifier: "MCA3", applicationtype: "MCA3Type")
# MCerebrumApplication.create!(identifier: "MCA4", applicationtype: "MCA4Type")
# MCerebrumApplication.create!(identifier: "MCA5", applicationtype: "MCA5Type")
#
# MCerebrumPlatform.create!(identifier: "MCP1", platformtype: "MCP1Type")
# MCerebrumPlatform.create!(identifier: "MCP2", platformtype: "MCP2Type")
# MCerebrumPlatform.create!(identifier: "MCP3", platformtype: "MCP3Type")
# MCerebrumPlatform.create!(identifier: "MCP4", platformtype: "MCP4Type")
# MCerebrumPlatform.create!(identifier: "MCP5", platformtype: "MCP5Type")
#
# MCerebrumPlatformApp.create!(identifier: "MCPA1", platformapptype: "MCPA1Type")
# MCerebrumPlatformApp.create!(identifier: "MCPA2", platformapptype: "MCPA2Type")
# MCerebrumPlatformApp.create!(identifier: "MCPA3", platformapptype: "MCPA3Type")
# MCerebrumPlatformApp.create!(identifier: "MCPA4", platformapptype: "MCPA4Type")
# MCerebrumPlatformApp.create!(identifier: "MCPA5", platformapptype: "MCPA5Type")
#
#
# Datasource.create!(identifier: "DSC1", datasourcetype: "DSC1_type", m_cerebrum_application_id: 1, m_cerebrum_platform_id: 1, m_cerebrum_platform_app_id: 1)
# Datasource.create!(identifier: "DSC2", datasourcetype: "DSC2_type", m_cerebrum_application_id: 2, m_cerebrum_platform_id: 2, m_cerebrum_platform_app_id: 2)
# Datasource.create!(identifier: "DSC3", datasourcetype: "DSC3_type", m_cerebrum_application_id: 3, m_cerebrum_platform_id: 3, m_cerebrum_platform_app_id: 3)
# Datasource.create!(identifier: "DSC4", datasourcetype: "DSC4_type", m_cerebrum_application_id: 4, m_cerebrum_platform_id: 4, m_cerebrum_platform_app_id: 4)
# Datasource.create!(identifier: "DSC5", datasourcetype: "DSC5_type", m_cerebrum_application_id: 5, m_cerebrum_platform_id: 5, m_cerebrum_platform_app_id: 5)
#
# Participant.create!(identifier: 'TestUser1')
# Participant.create!(identifier: 'TestUser2')
#
# Study.create!(identifier: 'Study1', name: 'Study Test 1')
# Study.create!(identifier: 'Study2', name: 'Study Test 2')
#
# Datastream.create!(datasource_id: 1, participant_id: 1)
# Datastream.create!(datasource_id: 2, participant_id: 1)
# Datastream.create!(datasource_id: 3, participant_id: 1)
# Datastream.create!(datasource_id: 4, participant_id: 1)
# Datastream.create!(datasource_id: 5, participant_id: 1)
#
# Datapoint.create!(timestamp: Date.new, sample: {value: 1}, datastream_id: 1)
# Datapoint.create!(timestamp: Date.new, sample: {value: 2}, datastream_id: 1)
# Datapoint.create!(timestamp: Date.new, sample: {value: 3}, datastream_id: 1)
# Datapoint.create!(timestamp: Date.new, sample: {value: 4}, datastream_id: 1)
# Datapoint.create!(timestamp: Date.new, sample: {value: 5}, datastream_id: 1)
# Datapoint.create!(timestamp: Date.new, sample: {value: 6}, datastream_id: 2)
# Datapoint.create!(timestamp: Date.new, sample: {value: 7}, datastream_id: 2)
# Datapoint.create!(timestamp: Date.new, sample: {value: 8}, datastream_id: 2)
# Datapoint.create!(timestamp: Date.new, sample: {value: 9}, datastream_id: 3)
# Datapoint.create!(timestamp: Date.new, sample: {value: 10}, datastream_id: 4)
