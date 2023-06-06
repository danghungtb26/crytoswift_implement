/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, {useRef} from 'react';
import {
  Alert,
  Button,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';
import {Colors} from 'react-native/Libraries/NewAppScreen';

import {
  SecurePasscodeTextField,
  initializeUXComponents,
} from '@weavr-io/secure-components-react-native';

const WEAVR_UI_KEY = 'EkjqJR2pykEBgZr33toADA==';

initializeUXComponents('Sandbox', WEAVR_UI_KEY)
  .then(res => console.log(res))
  .catch(e => console.log(e));

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const textFieldRef = useRef<any>();
  //tag is only required for group actions
  const [tagPass1, setTagPass1] = React.useState<string | undefined>();
  const onPassToken = (resp: any) => {
    console.log(resp);
    // setPasscode(resp.value);
    console.log(resp.value);
    Alert.alert(resp.value);
  };
  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <View style={styles.full}>
          <SecurePasscodeTextField
            placeholder="Enter Passcode"
            style={styles.fieldBox} //only define sizing
            textSize="16"
            background={true} //here default behaviour is system default
            onCreateToken={onPassToken}
            onGetTag={(resp: any) => {
              console.log(resp);
              setTagPass1(resp.value);
            }}
            onTextChanges={resp => {
              console.log(resp);
            }}
            onFocus={resp => {
              console.log(resp);
            }}
            ref={textFieldRef}
            placeholderTextColor="#000000"
          />
          <Button
            onPress={() => {
              textFieldRef.current.createToken();
            }}
            title="Token"
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  full: {
    flex: 1,
  },
  fieldBox: {
    width: '100%',
    height: 100,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
