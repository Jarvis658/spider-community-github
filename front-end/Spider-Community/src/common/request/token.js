
/**
 * 获取本地存储的token
 */
export const getLocalToken = () => localStorage.getItem("Token") || '';
/**
 * 将token存储于本地
 */
export const setLocalToken = (token) => localStorage.setItem("Token", token);

export const removeLocalToken = () => localStorage.removeItem("Token");