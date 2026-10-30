/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../daily_logs/daily_log_endpoint.dart' as _i4;
import '../field_values/field_value_endpoint.dart' as _i5;
import '../fields/field_endpoint.dart' as _i6;
import '../greetings/greeting_endpoint.dart' as _i7;
import '../subtopics/subtopic_endpoint.dart' as _i8;
import '../topics/topic_endpoint.dart' as _i9;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i10;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i11;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'dailyLog': _i4.DailyLogEndpoint()
        ..initialize(
          server,
          'dailyLog',
          null,
        ),
      'fieldValue': _i5.FieldValueEndpoint()
        ..initialize(
          server,
          'fieldValue',
          null,
        ),
      'field': _i6.FieldEndpoint()
        ..initialize(
          server,
          'field',
          null,
        ),
      'greeting': _i7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'subtopic': _i8.SubtopicEndpoint()
        ..initialize(
          server,
          'subtopic',
          null,
        ),
      'topic': _i9.TopicEndpoint()
        ..initialize(
          server,
          'topic',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['dailyLog'] = _i1.EndpointConnector(
      name: 'dailyLog',
      endpoint: endpoints['dailyLog']!,
      methodConnectors: {
        'createDailyLog': _i1.MethodConnector(
          name: 'createDailyLog',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dailyLog'] as _i4.DailyLogEndpoint)
                  .createDailyLog(
                    session,
                    params['subtopicId'],
                    params['date'],
                  ),
        ),
        'getDailyLogs': _i1.MethodConnector(
          name: 'getDailyLogs',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dailyLog'] as _i4.DailyLogEndpoint).getDailyLogs(
                    session,
                    params['subtopicId'],
                  ),
        ),
      },
    );
    connectors['fieldValue'] = _i1.EndpointConnector(
      name: 'fieldValue',
      endpoint: endpoints['fieldValue']!,
      methodConnectors: {
        'saveFieldValue': _i1.MethodConnector(
          name: 'saveFieldValue',
          params: {
            'dailyLogId': _i1.ParameterDescription(
              name: 'dailyLogId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['fieldValue'] as _i5.FieldValueEndpoint)
                  .saveFieldValue(
                    session,
                    params['dailyLogId'],
                    params['fieldId'],
                    params['value'],
                  ),
        ),
        'getFieldValues': _i1.MethodConnector(
          name: 'getFieldValues',
          params: {
            'dailyLogId': _i1.ParameterDescription(
              name: 'dailyLogId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['fieldValue'] as _i5.FieldValueEndpoint)
                  .getFieldValues(
                    session,
                    params['dailyLogId'],
                  ),
        ),
      },
    );
    connectors['field'] = _i1.EndpointConnector(
      name: 'field',
      endpoint: endpoints['field']!,
      methodConnectors: {
        'getFields': _i1.MethodConnector(
          name: 'getFields',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['field'] as _i6.FieldEndpoint).getFields(
                session,
                params['subtopicId'],
              ),
        ),
        'createField': _i1.MethodConnector(
          name: 'createField',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'position': _i1.ParameterDescription(
              name: 'position',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['field'] as _i6.FieldEndpoint).createField(
                session,
                params['subtopicId'],
                params['name'],
                params['type'],
                params['position'],
              ),
        ),
        'updateField': _i1.MethodConnector(
          name: 'updateField',
          params: {
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['field'] as _i6.FieldEndpoint).updateField(
                session,
                params['fieldId'],
                params['name'],
                params['type'],
              ),
        ),
        'deleteField': _i1.MethodConnector(
          name: 'deleteField',
          params: {
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['field'] as _i6.FieldEndpoint).deleteField(
                session,
                params['fieldId'],
              ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i7.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['subtopic'] = _i1.EndpointConnector(
      name: 'subtopic',
      endpoint: endpoints['subtopic']!,
      methodConnectors: {
        'getSubtopics': _i1.MethodConnector(
          name: 'getSubtopics',
          params: {
            'topicId': _i1.ParameterDescription(
              name: 'topicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtopic'] as _i8.SubtopicEndpoint).getSubtopics(
                    session,
                    params['topicId'],
                  ),
        ),
        'createSubtopic': _i1.MethodConnector(
          name: 'createSubtopic',
          params: {
            'topicId': _i1.ParameterDescription(
              name: 'topicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtopic'] as _i8.SubtopicEndpoint)
                  .createSubtopic(
                    session,
                    params['topicId'],
                    params['name'],
                    params['description'],
                  ),
        ),
        'updateSubtopic': _i1.MethodConnector(
          name: 'updateSubtopic',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtopic'] as _i8.SubtopicEndpoint)
                  .updateSubtopic(
                    session,
                    params['subtopicId'],
                    params['name'],
                    params['description'],
                  ),
        ),
        'deleteSubtopic': _i1.MethodConnector(
          name: 'deleteSubtopic',
          params: {
            'subtopicId': _i1.ParameterDescription(
              name: 'subtopicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtopic'] as _i8.SubtopicEndpoint)
                  .deleteSubtopic(
                    session,
                    params['subtopicId'],
                  ),
        ),
      },
    );
    connectors['topic'] = _i1.EndpointConnector(
      name: 'topic',
      endpoint: endpoints['topic']!,
      methodConnectors: {
        'getTopics': _i1.MethodConnector(
          name: 'getTopics',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['topic'] as _i9.TopicEndpoint).getTopics(session),
        ),
        'createTopic': _i1.MethodConnector(
          name: 'createTopic',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['topic'] as _i9.TopicEndpoint).createTopic(
                session,
                params['name'],
                params['description'],
              ),
        ),
        'updateTopic': _i1.MethodConnector(
          name: 'updateTopic',
          params: {
            'topicId': _i1.ParameterDescription(
              name: 'topicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['topic'] as _i9.TopicEndpoint).updateTopic(
                session,
                params['topicId'],
                params['name'],
                params['description'],
              ),
        ),
        'deleteTopic': _i1.MethodConnector(
          name: 'deleteTopic',
          params: {
            'topicId': _i1.ParameterDescription(
              name: 'topicId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['topic'] as _i9.TopicEndpoint).deleteTopic(
                session,
                params['topicId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i10.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i11.Endpoints()
      ..initializeEndpoints(server);
  }
}
