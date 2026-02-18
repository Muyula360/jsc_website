import { useEffect } from 'react';
import zxcvbn from 'zxcvbn';

const PwdStrengthMeter = ({ createdPwd, updatePwdScore }) => {

    let progressBarClass = 'progress-bar';


    useEffect(() => {

        if (createdPwd.length < 1) {
            updatePwdScore(0);
        } else {
            const pwdTestRslt = zxcvbn(createdPwd);
            updatePwdScore(pwdTestRslt.score);
        }

    }, [createdPwd, updatePwdScore]);

    
    if (createdPwd.length > 0) {
        const pwdTestRslt = zxcvbn(createdPwd);
        
        switch(pwdTestRslt.score) {
            case 0: 
                progressBarClass = 'progress-bar bg-danger w-25';
                break;
            case 1: 
                progressBarClass = 'progress-bar bg-danger w-25';
                break;
            case 2: 
                progressBarClass = 'progress-bar bg-warning w-50';
                break;
            case 3: 
                progressBarClass = 'progress-bar bg-primary w-75';
                break;
            case 4: 
                progressBarClass = 'progress-bar bg-success w-100';
                break;
            default: 
                progressBarClass = 'progress-bar';
        }
    }

    return (
        <div className='progress rounded-0 mx-3' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style={{ height: '0.3rem' }}>
            <div className={progressBarClass}></div>
        </div>
    );
}

export default PwdStrengthMeter;